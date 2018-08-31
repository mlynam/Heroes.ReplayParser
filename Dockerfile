# Stage 1
FROM microsoft/aspnetcore-build AS builder
WORKDIR /source

# caches restore result by copying csproj file separately
COPY **/*.csproj ./
RUN dotnet restore Heroes.ReplayParser/Heroes.ReplayParser.netstandard.csproj
RUN dotnet restore MpqTool/MpqTool.netstandard.csproj

# copies the rest of your code
COPY . .
RUN dotnet publish --output /app/ --configuration Release

# Stage 2
FROM microsoft/aspnetcore
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "aspdocker.dll"]