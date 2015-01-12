package Tables;

import sun.security.krb5.internal.PAData;

/**
 * Created by brandon on 08/12/14.
 */
public class Sales {
    private String date;// TEXT NOT NULL, --date of sale YYYY-MM-DD
    private Integer patient;// INTEGER NOT NULL,
    private Integer frame;// INTEGER NOT NULL references frames(frame_id),
    private Integer lenses;// INTEGER NOT NULL references lenses(lense_id),
    public Sales(String date, Integer patient, Integer frame, Integer lenses){
        this.date=date;
        this.patient=patient;
        this.frame=frame;
        this.lenses=lenses;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getPatient() {
        return patient;
    }

    public void setPatient(Integer patient) {
        this.patient = patient;
    }

    public Integer getFrame() {
        return frame;
    }

    public void setFrame(Integer frame) {
        this.frame = frame;
    }

    public Integer getLenses() {
        return lenses;
    }

    public void setLenses(Integer lenses) {
        this.lenses = lenses;
    }
    public String toString(){
        return date+"|"+patient+"|"+frame+"|"+lenses;
    }
}
