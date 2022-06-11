using InfilonPractical.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace InfilonPractical.Interface
{
    public interface IUserService
    {
        Task Insert();

        List<UserEntity> GetAll();
        List<UserListJson> GetAllAsJson();
        UserEntity GetById(int? id);
        void SaveUser(UserEntity user);
    }
}
