#region Usings

using System;
using System.Data.Entity;

#endregion

namespace EFCodeFirst
{
    internal class DataModel
    {
        public class Topic
        {
            public int Id { get; set; }
            public string Title { get; set; }
            public DateTime StartDate { get; set; }

            public Presenter Presenter { get; set; }
        }

        public class Presenter
        {

            public int Id { get; set; }
            public string Name { get; set; }
        }

        public class DevForumDbContext : DbContext
        {
            public DevForumDbContext():base("devforumdb")
            {
                
            }
            public DbSet<Topic> Topics { get; set; }
            public DbSet<Presenter> Presenters { get; set; }
        }
    }
}