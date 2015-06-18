
# Start the app

```
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.1 bundle install

docker build -t my-ruby-app .
docker run -it --name my-running-script my-ruby-app

```

```
docker-compose up
```
