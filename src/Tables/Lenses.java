package Tables;

/**
 * Created by brandon on 08/12/14.
 */
public class Lenses {

    private Integer lense_id;// INTEGER primary key NOT NULL, --auto increment key
    private String type;// TEXT default NULL, --sv,bifocals,progressives,etc
    private String material;// TEXT default NULL, --what the lenses are made of
    private String base_curve;// TEXT default NULL, --base curve of the lense
    private Double cost;// DOUBLE NOT NULL --the cost of the frames by themselves

    public Lenses(Integer lense_id, Double cost){
        this.lense_id=lense_id;
        this.cost=cost;
    }

    public Integer getLense_id() {
        return lense_id;
    }

    public void setLense_id(Integer lense_id) {
        this.lense_id = lense_id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getBase_curve() {
        return base_curve;
    }

    public void setBase_curve(String base_curve) {
        this.base_curve = base_curve;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }
}
