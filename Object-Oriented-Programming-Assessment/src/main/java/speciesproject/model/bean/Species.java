package speciesproject.model.bean;

public class Species {

    protected int id; 
    protected String title;
    protected int categoryId; 
    protected String createdDate; 
    protected String content;
    protected boolean isHidden; 

    // Default constructor
    public Species() {}

    // Constructor without ID (for inserting new species)
    public Species(String title, int categoryId, String createdDate, String content, boolean isHidden) {
        this.title = title;
        this.categoryId = categoryId;
        this.createdDate = createdDate;
        this.content = content;
        this.isHidden = isHidden;
    }

    // Constructor with ID (for updating existing species)
    public Species(int id, String title, int categoryId, String createdDate, String content, boolean isHidden) {
        this.id = id;
        this.title = title;
        this.categoryId = categoryId;
        this.createdDate = createdDate;
        this.content = content;
        this.isHidden = isHidden;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean isHidden() {
		return isHidden;
	}

	public void setHidden(boolean isHidden) {
		this.isHidden = isHidden;
	}

   
}
