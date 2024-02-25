package vo;

public class AptVo {
	private int aptIdx;
	private String homeType;
	private String name;
	private int noh;
	private String dateCompletion;
	private String address;
	private double latitude;
	private double longitude;
	private int dong;
	private int parking;
	
	public AptVo(int aptIdx, String homeType, String name, int noh, String dateCompletion, String address,
			double latitude, double longitude, int dong, int parking) {
		this.aptIdx = aptIdx;
		this.homeType = homeType;
		this.name = name;
		this.noh = noh;
		this.dateCompletion = dateCompletion;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.dong = dong;
		this.parking = parking;
	}

	public int getAptIdx() {
		return aptIdx;
	}

	public String getHomeType() {
		return homeType;
	}

	public String getName() {
		return name;
	}

	public int getNoh() {
		return noh;
	}

	public String getDateCompletion() {
		return dateCompletion;
	}

	public String getAddress() {
		return address;
	}

	public double getLatitude() {
		return latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public int getDong() {
		return dong;
	}

	public int getParking() {
		return parking;
	}
	
	
}
