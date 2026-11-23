using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SecuritySatisfactionCertificate
/// </summary>
public class SecuritySatisfactionCertificate
{
    public string SSCNumber { get; set; }
    public DateTime CertificateDate { get; set; }

    public string CFRNumber { get; set; }
    public string BranchName { get; set; }
    public string RMName { get; set; }
    public string RMID { get; set; }
    public string BorrowerName { get; set; }

    public string ApprovalAuthority { get; set; }
    public string SanctionReference { get; set; }
    public DateTime? SanctionDate { get; set; }

    public string NatureOfFacility { get; set; }
    public decimal? LimitAsked { get; set; }
    public DateTime? SanctionExpiry { get; set; }
	public SecuritySatisfactionCertificate()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}