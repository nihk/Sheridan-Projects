// Contributors: Nick Rose
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace MovieWikiService
{
    // A service interface defining several basic database operations
    [ServiceContract]
    public interface IMovieWikiService
    {
        [OperationContract]
        int InsertWikiArticle(string articleType, string title, string descriptionXml);

        [OperationContract]
        int InsertWikiArticleEditHistory(int aticleId, int accountId, DateTime timestamp);

        [OperationContract]
        int InsertUserAccount(string username, string password);

        [OperationContract]
        int UpdateWikiArticle(int articleId, string descriptionXml);

        [OperationContract]
        int DeleteWikiArticle(int articleId);

        [OperationContract]
        DataSet GetAllWikiArticles();

        [OperationContract]
        DataSet GetAllWikiArticleEditHistories();

        [OperationContract]
        DataSet GetAllUserAccounts();
    }
}
