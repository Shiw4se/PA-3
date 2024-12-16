FROM alpine AS build
RUN apk add --no-cache git build-base cmake automake autoconf coreutils
WORKDIR /home/funcimg
COPY . /home/funcimg
RUN autoreconf -i
RUN ./configure
RUN make

FROM alpine
RUN apk add --no-cache libstdc++
COPY --from=build /home/funcimg/my_program /usr/local/bin/my_program
ENTRYPOINT ["/usr/local/bin/my_program"]

