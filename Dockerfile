# Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Copy the csproj file and restore dependencies
COPY OneElevenWebApi/*.csproj ./OneElevenWebApi/
RUN dotnet restore "OneElevenWebApi/OneElevenWebApi.csproj"

# Copy everything else and publish
COPY . .
WORKDIR "/src/OneElevenWebApi"
RUN dotnet publish "OneElevenWebApi.csproj" -c Release -o /app/publish

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "OneElevenWebApi.dll"]
