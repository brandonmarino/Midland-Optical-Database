package Tables;

/**
 * Created by brandon on 08/12/14.
 */
public class Insurance {
    private String policy_no;
    private String company; //TEXT NOT NULL, --examples: Manulife, BMO, Aviva
    private Double allotment;// DOUBLE default NULL, --business owner may need to leave this value blank to enter it later after consulting the company for the alloted funds
    private Double used;// DOUBLE default NULL -- may be left unfilled for the above reason

    public Insurance(String policy_no, String company){
        this.policy_no=policy_no;
        this.company=company;
    }

    public String getPolicy_no() {
        return policy_no;
    }

    public void setPolicy_no(String policy_no) {
        this.policy_no = policy_no;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Double getAllotment() {
        return allotment;
    }

    public void setAllotment(Double allotment) {
        this.allotment = allotment;
    }

    public Double getUsed() {
        return used;
    }

    public void setUsed(Double used) {
        this.used = used;
    }
    public String toString(){
        return policy_no+"|"+company;
    }
}
