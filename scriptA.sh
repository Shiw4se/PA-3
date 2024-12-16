#!/bin/bash

# Функція для перевірки використання CPU контейнера
get_cpu_usage() {
    docker stats --no-stream --format "{{.CPUPerc}}" "$1" | awk -F'%' '{print $1}'
}

# Запуск контейнера на конкретному ядрі CPU
launch_container() {
    container=$1
    cpu=$2
    # Перевірка, чи контейнер вже існує
    if [ "$(docker ps -q -f name=$container)" ]; then
        echo "Контейнер $container вже існує, зупиняємо його..."
        docker stop "$container"
        docker rm "$container"
    fi
    echo "Запуск контейнера $container на ядрі $cpu..."
    docker run -d --name "$container" --cpuset-cpus="$cpu" --network my-network andrey2281488/funcserver1
}

# Оновлення контейнерів
update_containers() {
    docker pull andrey2281488/funcserver1:latest
    for container in srv1 srv2 srv3; do
        if [ "$(docker ps -q -f name=$container)" ]; then
            echo "Оновлення $container..."
            docker stop "$container"
            docker rm "$container"
            launch_container "$container" 0
        fi
    done
}

# Моніторинг стану контейнерів та запуск/зупинка залежно від умов
monitor_containers() {
    srv2_last_active=$(date +%s)
    srv3_last_active=$(date +%s)

    while true; do
        current_time=$(date +%s)

        # Перевірка для всіх контейнерів
        for container in srv1 srv2 srv3; do
            if [ "$(docker ps -q -f name=$container)" ]; then
                usage=$(get_cpu_usage "$container")

                # Якщо використання CPU більше 40%, то запускаємо наступний контейнер
                if (( $(echo "$usage > 40" | bc -l) )); then
                    echo "$container перевантажений..."
                    if [ "$container" == "srv2" ] && [ ! "$(docker ps -q -f name=srv3)" ]; then
                        echo "Запуск srv3, так як srv2 перевантажений..."
                        launch_container srv3 2
                    elif [ "$container" == "srv1" ] && [ ! "$(docker ps -q -f name=srv2)" ]; then
                        echo "Запуск srv2, так як srv1 перевантажений..."
                        launch_container srv2 1
                    fi
                fi

                # Якщо контейнер навантажує ядро більше 10%, обнуляємо таймер активності
                if (( $(echo "$usage > 10" | bc -l) )); then
                    if [ "$container" == "srv2" ]; then
                        srv2_last_active=$current_time
                    elif [ "$container" == "srv3" ]; then
                        srv3_last_active=$current_time
                    fi
                fi

                # Перевірка на неактивність (від останньої активності)
                if [ "$container" != "srv1" ]; then
                    last_active_var="${container}_last_active"
                    last_active_time=${!last_active_var}
                    if [ $(($current_time - $last_active_time)) -gt 60 ]; then
                        echo "$container неактивний більше 1 хвилини, зупиняємо..."
                        docker stop "$container"
                        docker rm "$container"
                    fi
                fi
            fi
        done

        # Перевірка на наявність нової версії контейнера кожні 2 хвилини
        if [ $(( $current_time % 120 )) -eq 0 ]; then
            update_containers
        fi

        sleep 5
    done
}

# Основний виконуваний код
launch_container srv1 0
monitor_containers

