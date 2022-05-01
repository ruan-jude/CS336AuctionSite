package item;

public class Shoes extends Item {

	int size;
	
	public Shoes(String name, String color, Season season, int size) {
		super(name, color, season);
		this.size = size;
	}
	
	public int getSize() {
		return size;
	}
}
