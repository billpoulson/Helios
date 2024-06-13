### Install Tooling

```sh {"id":"01HZ15VJ51TFK7KQHVFF94RVR2"}
dotnet tool install -g dotnet-aspnet-codegenerator
dotnet tool install -g dotnet-ef
```

### Add Required Packages

```sh {"id":"01HZ14XF4SH5GKKE6XNVAZYNYS"}
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Microsoft.EntityFrameworkCore.SqlServer  # Use the appropriate provider for your database
dotnet add package Microsoft.EntityFrameworkCore.Sqlite


```

### Generate Controller

```sh {"id":"01HZ14T2XSZYX2FN8AK3FBHMB9"}
dotnet aspnet-codegenerator controller -name YourControllerName -m Product -dc MyDbContext --relativeFolderPath Controllers --useDefaultLayout --referenceScriptLibraries

```

### Create Initial DB Migration

```sh {"id":"01HZ1583JKPEV1B3KBB8DVJTHB"}
dotnet ef migrations add InitialCreate

```
