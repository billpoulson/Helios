using Microsoft.EntityFrameworkCore;

public class Product
{
    public int ProductId { get; set; }

    public required string Name { get; set; }
    public decimal Price { get; set; }
}

public class MyDbContext : DbContext
{
    private readonly IConfiguration _configuration;
    public DbSet<Product> Products { get; set; }

    public MyDbContext(DbContextOptions<MyDbContext> options, IConfiguration configuration)
        : base(options)
    {
        _configuration = configuration;
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var connectionString = _configuration.GetConnectionString("DefaultConnection")!;

            if (connectionString.Contains("Data Source"))
            {
                optionsBuilder.UseSqlite(connectionString);
            }
            else
            {
                optionsBuilder.UseSqlServer(connectionString);
            }
        }
    }
}
