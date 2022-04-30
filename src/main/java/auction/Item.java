package auction;

public abstract class Item {

	private int itemID;
	
	private enum Type { Shoes, Pants, Shirt, Jacket };
	private Type type;
	
	private String name;
	private String color;
	
	private enum Season { Spring, Summer, Fall, Winter };
	private Season season;
	
	public Item(Type type, String name, String color, Season season) {
		this.type = type;
		this.name = name;
		this.color = color;
		this.season = season;
	}
	
	public Type getType() {
		return type;
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
