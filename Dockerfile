# # escape=`
# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019
# WORKDIR /src

# COPY *.sln .
# RUN nuget restore C:\Users\hp\source\repos\WebApplication3.sln `
#     && msbuild C:\Users\hp\source\repos\WebApplication3\WebApplication3.csproj /p:OutputPath=c:\out /p:Configuration=Release

# # app image
# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
# SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# WORKDIR C:\web-app
# RUN New-WebApplication -Name 'app' -Site 'dotnetframework paystackintegrationapi site' -PhysicalPath C:\web-app

# COPY --from=builder C:\out\_PublishedWebsites\WebApplication3 .





FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app
ARG src="EcommerceApi-dotNetFramework/."
COPY . .
WORKDIR ${src}
RUN msbuild /p:Configuration=Release
FROM mcr.microsoft.com/dotnet/framework/runtime:4.8 AS runtime
EXPOSE 80
EXPOSE 808
WORKDIR /app
COPY --from=build /app/EcommerceApi-dotNetFramework/obj/release .
ENTRYPOINT EcommerceApi-dotNetFramework.exe




# #Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
# # #For more information, please see https://aka.ms/containercompat 
# FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder
# WORKDIR /src
# COPY *.sln .

# # copy and restore all projects
# COPY EcommerceApi-dotNetFramework/*.csproj EcommerceApi-dotNetFramework/

# # Copy everything else
# COPY . .

# # app image
# FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8
# SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# WORKDIR /src/EcommerceApi-dotNetFramework

# COPY --from=builder /src/EcommerceApi-dotNetFramework/ .
# ENTRYPOINT ["dotnet", "EcommerceApi-dotNetFramework.dll"]
