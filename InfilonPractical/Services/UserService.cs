using Dapper;
using InfilonPractical.Interface;
using InfilonPractical.Models;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace InfilonPractical.Services
{
    public class UserService : IUserService
    {
        public List<UserEntity> GetAll()
        {
            List<UserEntity> users = new List<UserEntity>();
            var parameters = new DynamicParameters();
            using (IDbConnection con = new SqlConnection(AppSettings.ConnectionString))
            {
                var task = con.QueryMultiple(SqlConstant.GetAllUser, parameters, commandType: CommandType.StoredProcedure);
                users = task.Read<UserEntity>().ToList();
            }
            return users;
        }

        public List<UserListJson> GetAllAsJson()
        {
            List<UserListJson> users = new List<UserListJson>();
            var parameters = new DynamicParameters();
            using (IDbConnection con = new SqlConnection(AppSettings.ConnectionString))
            {
                var task = con.QueryMultiple(SqlConstant.GetUserJson, parameters, commandType: CommandType.StoredProcedure);
                users = task.Read<UserListJson>().ToList();
            }
            return users;
        }

        public UserEntity GetById(int? id)
        {
            UserEntity user = new UserEntity();
            var parameters = new DynamicParameters();
            parameters.Add("@Id", id, DbType.Int32, ParameterDirection.Input);
            using (IDbConnection con = new SqlConnection(AppSettings.ConnectionString))
            {
                var task = con.QueryMultiple(SqlConstant.GetUserById, parameters, commandType: CommandType.StoredProcedure);
                user = task.Read<UserEntity>().FirstOrDefault();
            }
            return user;
        }

        public async Task Insert()
        {
            try
            {
                List<UserEntity> userEntities = new List<UserEntity>();
                AppSettings appSettings = new AppSettings();
                using (var client = new HttpClient())
                {
                    HttpResponseMessage response = await client.GetAsync(AppSettings.GetUrl);
                    userEntities = await response.Content.ReadAsAsync<List<UserEntity>>();
                }
                if (userEntities?.Count > 0)
                {
                    var table = new DataTable();
                    table.Columns.Add("UserId", typeof(int));
                    table.Columns.Add("Id", typeof(int));
                    table.Columns.Add("Title", typeof(string));
                    table.Columns.Add("Completed", typeof(string));

                    foreach (var entity in userEntities)
                    {
                        var row = table.NewRow();
                        row["UserId"] = entity.UserId;
                        row["Id"] = entity.Id;
                        row["Title"] = entity.Title;
                        row["Completed"] = entity.Completed;
                        table.Rows.Add(row);
                    }
                    var parameters = new DynamicParameters();
                    parameters.Add("@UserData", table, DbType.Object, ParameterDirection.Input);
                    using (IDbConnection con = new SqlConnection(AppSettings.ConnectionString))
                    {
                        var task = con.QueryMultiple(SqlConstant.InsertUser, parameters, commandType: CommandType.StoredProcedure);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void SaveUser(UserEntity user)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@Id", user.Id, DbType.Int32, ParameterDirection.Input);
            parameters.Add("@UserId", user.UserId, DbType.Int32, ParameterDirection.Input);
            parameters.Add("@Title", user.Title, DbType.String, ParameterDirection.Input);
            parameters.Add("@Completed", user.Completed, DbType.Boolean, ParameterDirection.Input);
            using (IDbConnection con = new SqlConnection(AppSettings.ConnectionString))
            {
                var task = con.QueryMultiple(SqlConstant.SaveUser, parameters, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
