package item;

public abstract class Item {

	private int itemID;
	
	private String name;
	private String color;
	
	public enum Season { Spring, Summer, Fall, Winter };
	private Season season;
	
	public Item(String name, String color, Season season) {
		this.name = name;
		this.color = color;
		this.season = season;
	}
	
	public String getName() {
		return name;
	}
	
	public String getColor() {
		return color;
	}
	
	public Season getSeason() {
		return season;
	}
	
	public void setID(int itemID) {
		this.itemID = itemID;
	}
	
	public int getID() {
		return itemID;
	}
}
