docker build -t chrono:debug --no-cache --build-arg="BUILD_TYPE=Debug" .
docker build -t chrono:release --build-arg="BUILD_TYPE=Release" .