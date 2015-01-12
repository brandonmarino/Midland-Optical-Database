package Tables;

/**
 * Created by brandon on 08/12/14.
 */
public class Frames {
    private Integer frame_id;// INTEGER primary key NOT NULL, --auto increment key
    private String model;// TEXT NOT NULL, --model tag of the frame pair
    private String manufacturer;// TEXT NOT NULL, --manufacter of the lenses (Oakly, Addidas, etc)
    private String frame_material;// TEXT NOT NULL, --plastic, metal, etc
    private String colour;// TEXT NOT NULL, --colour of the frames
    private Double cost;// DOUBLE NOT NULL --cost of the frames

    public Frames(Integer frame_id, String model, String manufacturer, String frame_material, String colour, Double cost) {
        this.frame_id = frame_id;
        this.model = model;
        this.manufacturer = manufacturer;
        this.frame_material = frame_material;
        this.colour = colour;
        this.cost = cost;
    }

    public Integer getFrame_id() {
        return frame_id;
    }

    public void setFrame_id(Integer frame_id) {
        this.frame_id = frame_id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getFrame_material() {
        return frame_material;
    }

    public void setFrame_material(String frame_material) {
        this.frame_material = frame_material;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public String toString() {
        return frame_id + "|" + model + "|" + manufacturer + "|" + frame_material + "|" + colour + "|" + cost;
    }
}