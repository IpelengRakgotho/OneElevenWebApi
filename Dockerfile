# Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["OneElevenWebApi/OneElevenWebApi.csproj", "OneElevenWebApi/"]
RUN dotnet restore "OneElevenWebApi/OneElevenWebApi.csproj"

# Copy everything else and build
COPY . .
WORKDIR "/src/OneElevenWebApi"
RUN dotnet publish "OneElevenWebApi.csproj" -c Release -o /app/publish

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "OneElevenWebApi.dll"]
