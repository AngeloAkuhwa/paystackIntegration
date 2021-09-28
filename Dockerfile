#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat 
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder
WORKDIR /src
COPY *.sln .

# copy and restore all projects
COPY EcommerceApi-dotNetFramework/*.csproj EcommerceApi-dotNetFramework/

# Copy everything else
COPY . .

#Publishing


# app image
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR /src/EcommerceApi-dotNetFramework

COPY --from=builder /src/EcommerceApi-dotNetFramework/ .
# COPY --from=publish /src/publish .
ENTRYPOINT ["dotnet", "EcommerceApi-dotNetFramework.dll"]

