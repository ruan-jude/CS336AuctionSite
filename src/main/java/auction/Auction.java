package auction;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map.Entry;

import item.Item;
import userType.User;

public class Auction {

	private Item item;
	private HashMap<User, Double> bidders;
	private double initPrice;
	private double increment;
	private double minPrice;
	//NEED TO HAVE A END DATE BUT IDK HOW TO DO THAT
	private User winner;
	
	public Auction(Item item, double initPrice, double increment, double minPrice) {
		this.item = item;
		this.initPrice = initPrice;
		this.increment = increment;
		this.minPrice = minPrice;
		bidders = new HashMap<>();
		this.winner = null;
	}
	
	public Item getItem() { return item; }
	public double getinitPrice() { return initPrice; }
	public double getIncrement() { return increment; }
	public double getminPrice() { return minPrice; }
	
	public void setWinner() {
		//IF AUCTION PASSED DATE:
		double maxValueInMap=(Collections.max(bidders.values()));  // This will return max value in the Hashmap
        for (Entry<User, Double> entry : bidders.entrySet()) {  // Itrate through hashmap
            if (entry.getValue()==maxValueInMap) {
                this.winner = entry.getKey();     // Print the key with max value
            }
        }
		//ELSE throw an error
	}
	
	public User getWinner() {
		return winner;
	}
	
}
