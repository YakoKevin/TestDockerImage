FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build-env
WORKDIR /TestDockerImage
COPY ./ .
RUN dotnet publish -c Release -o output

FROM nginx:alpine
WORKDIR /var/www/web
COPY --from=build-env /TestDockerImage/output/wwwroot .
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80