using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace CAD.DataAccess
{
    public class SSCData
    {
        public string Id { get; set; }
        public string CfrNo { get; set; }
        public string BranchName { get; set; }
        public string RmName { get; set; }       // not in your SP result set — see note below
        public string RmId { get; set; }         // not in your SP result set — see note below
        public string CustomerName { get; set; }
        public string SancAuthority { get; set; }
        public string SancReferenceNo { get; set; }
        public string SancDate { get; set; }
        public string LoanNatures { get; set; }
        public string LoanAmount { get; set; }
        public string ExpDate { get; set; }
        public List<PendingDocument> PendingDocuments { get; set; }

        public SSCData()
        {
            PendingDocuments = new List<PendingDocument>();
        }
    }

    public class PendingDocument
    {
        public int DocSl { get; set; }
        public string DocName { get; set; }
        public string Status { get; set; }
        public string Details { get; set; }
        public string Deadline { get; set; }
    }
}