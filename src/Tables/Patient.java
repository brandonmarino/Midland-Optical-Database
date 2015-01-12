package Tables;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by brandon on 08/12/14.
 */
public class Patient {
    private Integer id = null;
    private String first = null;
    private String last = null;
    private String street = null;
    private String city = null;
    private String province = null;
    private String phoneNumber = null;
    private String phoneNumber2 = null;
    private String occupation = null;
    private String policy_no = null;
    private Integer refferedBy = null;
    private String email = null;
    public Patient(){}
    public Patient(Integer id, String first, String last, String street, String city, String province, String phoneNumber){
        this.id=id;
        this.first=first;
        this.last=last;
        this.street=street;
        this.city=city;
        this.province=province;
        this.phoneNumber=phoneNumber;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirst() {
        return first;
    }

    public void setFirst(String first) {
        this.first = first;
    }

    public String getLast() {
        return last;
    }

    public void setLast(String last) {
        this.last = last;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber2() {
        return phoneNumber2;
    }

    public void setPhoneNumber2(String phoneNumber2) {
        this.phoneNumber2 = phoneNumber2;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getPolicy_no() {
        return policy_no;
    }

    public void setPolicy_no(String policy_no) {
        this.policy_no = policy_no;
    }

    public Integer getRefferedBy() {
        return refferedBy;
    }

    public void setRefferedBy(Integer refferedBy) {
        this.refferedBy = refferedBy;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String toString(){
        return ""+first+" "+last+"|"+street+", "+city+", "+province+"|"+phoneNumber;
    }

    public void databaseSave(Connection databaseConnection) {
        try {
            String statement;
            if(id != null) {
                statement = "update patients SET ";
                if (first != null)
                    statement +="first_name='" + first + "',";
                else
                    statement +="first_name=NULL,";
                if (last != null)
                    statement +="last_name='" + last + "',";
                else
                    statement +="last_name=NULL,";
                if (street != null)
                    statement +="st_address='" + street + "',";
                else
                    statement +="st_address=NULL,";
                if (city != null)
                    statement +="city='" + city + "',";
                else
                    statement +="city=NULL,";
                if (province != null)
                    statement +="province='" + province + "',";
                else
                    statement +="province=NULL,";
                if (phoneNumber != null)
                    statement +="primary_phoneNo='" + phoneNumber + "',";
                else
                    statement +="primary_phoneNo=NULL,";
                if (phoneNumber2 != null)
                    statement +="secondary_phoneNo='" + phoneNumber2 + "',";
                else
                    statement +="secondary_phoneNo=NULL,";
                if (occupation != null)
                    statement +="occupation='" + occupation + "',";
                else
                    statement +="occupation=NULL,";
                if (email != null)
                    statement +="email='" + email + "',";
                else
                    statement +="email=NULL,";
                if (policy_no!= null)
                    statement +="policy_no='" + policy_no + "',";
                else
                    statement +="policy_no=NULL,";
                if (policy_no!= null)
                    statement +="policy_no='" + policy_no + "'";
                else
                    statement +="policy_no=NULL";
                statement+=" WHERE px_id=" + id;
            }else{
                statement = "insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, secondary_phoneNo, occupation, email, policy_no) values ('" + first + "','" + last + "','" + street + "','" + city + "','" + province + "','" + phoneNumber + "',";

                if (phoneNumber2 != null)
                    statement +="'"+ phoneNumber2 + "',";
                else
                    statement +="NULL,";
                if (occupation != null)
                    statement +="'"+ occupation + "',";
                else
                    statement +="NULL,";
                if (email!= null)
                    statement +="'"+ email + "',";
                else
                    statement +="NULL,";
                if (policy_no!= null)
                    statement +="'"+ policy_no + "');";
                else
                    statement +="NULL);";

                //statement = "insert into patients (first_name, last_name, st_address, city, province, primary_phoneNo, secondary_phoneNo, occupation, email, policy_no) values ('" + first + "','" + last + "','" + street + "','" + city + "','" + province + "','" + phoneNumber + "','" + phoneNumber2 + "','" + occupation + "','" + email + "','" + policy_no + "')";
            }
            PreparedStatement prep = databaseConnection.prepareStatement(statement);
            prep.execute();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void copy(Patient other){
        id = other.id;
        first = other.first;
        last = other.last;
        street = other.street;
        city = other.city;
        province = other.province;
        phoneNumber = other.phoneNumber;
        phoneNumber2 = other.phoneNumber2;
        occupation = other.occupation;
        policy_no = other.policy_no;
        refferedBy = other.refferedBy;
        email = other.email;
    }
}
