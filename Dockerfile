FROM alpine AS build
RUN apk add --no-cache git build-base cmake automake autoconf coreutils
WORKDIR /home/funcimg
RUN git clone https://github.com/Shiw4se/PA-3.git .
RUN [ -f configure ] || autoreconf -i && chmod +x configure && ./configure && make

FROM alpine
RUN apk add --no-cache libstdc++
COPY --from=build /home/funcimg/my_program /usr/local/bin/my_program
ENTRYPOINT ["/usr/local/bin/my_program"]

