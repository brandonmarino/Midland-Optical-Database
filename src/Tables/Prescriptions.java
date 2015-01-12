package Tables;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by brandon on 08/12/14.
 */
public class Prescriptions {
    private Integer presc_id;// INTEGER primary key NOT NULL, --auto increment key
    private Integer patient;// INTEGER NOT NULL,
    private String OD;// TEXT default NULL,
    private String OS;// TEXT default NULL,
    private String presc_add;// TEXT default NULL,
    private String prism;// TEXT default NULL,
    private String date_RX;// TEXT default NULL, --Will be stored in the form of YYYY-MM-DD
    private String refferingDoctor;// TEXT default NULL,
    private String pupillaryDistance;// TEXT default NULL,
    private String seg;// TEXT default NULL,
    private String hts;// TEXT default NULL,
    private String frame_measurements;// TEXT default NULL,

    public Prescriptions(Integer presc_id, Integer patient) {
        this.presc_id = presc_id;
        this.patient = patient;
    }

    public Integer getPresc_id() {
        return presc_id;
    }

    public void setPresc_id(Integer presc_id) {
        this.presc_id = presc_id;
    }

    public Integer getPatient() {
        return patient;
    }

    public void setPatient(Integer patient) {
        this.patient = patient;
    }

    public String getOD() {
        return OD;
    }

    public void setOD(String OD) {
        this.OD = OD;
    }

    public String getOS() {
        return OS;
    }

    public void setOS(String OS) {
        this.OS = OS;
    }

    public String getPresc_add() {
        return presc_add;
    }

    public void setPresc_add(String presc_add) {
        this.presc_add = presc_add;
    }

    public String getPrism() {
        return prism;
    }

    public void setPrism(String prism) {
        this.prism = prism;
    }

    public String getDate_RX() {
        return date_RX;
    }

    public void setDate_RX(String date_RX) {
        this.date_RX = date_RX;
    }

    public String getRefferingDoctor() {
        return refferingDoctor;
    }

    public void setRefferingDoctor(String refferingDoctor) {
        this.refferingDoctor = refferingDoctor;
    }

    public String getPupillaryDistance() {
        return pupillaryDistance;
    }

    public void setPupillaryDistance(String pupillaryDistance) {
        this.pupillaryDistance = pupillaryDistance;
    }

    public String getSeg() {
        return seg;
    }

    public void setSeg(String seg) {
        this.seg = seg;
    }

    public String getHts() {
        return hts;
    }

    public void setHts(String hts) {
        this.hts = hts;
    }

    public String getFrame_measurements() {
        return frame_measurements;
    }

    public void setFrame_measurements(String frame_measurements) {
        this.frame_measurements = frame_measurements;
    }

    public String toString() {
        return presc_id + "|" + patient;
    }

}
