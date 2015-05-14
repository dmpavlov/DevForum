namespace EFCodeFirst.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddPresente : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Presenters",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            AddColumn("dbo.Topics", "Presenter_Id", c => c.Int());
            CreateIndex("dbo.Topics", "Presenter_Id");
            AddForeignKey("dbo.Topics", "Presenter_Id", "dbo.Presenters", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Topics", "Presenter_Id", "dbo.Presenters");
            DropIndex("dbo.Topics", new[] { "Presenter_Id" });
            DropColumn("dbo.Topics", "Presenter_Id");
            DropTable("dbo.Presenters");
        }
    }
}
