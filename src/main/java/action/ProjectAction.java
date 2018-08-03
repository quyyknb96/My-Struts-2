package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.AssignDAO;
import dao.ProjectDAO;
import dao.UserDAO;
import entity.Assign;
import entity.Project;
import entity.User;

import java.util.List;

public class ProjectAction extends ActionSupport {
    private int id;
    private List<Project> projectList;
    private Project project;
    private Assign assign;
    private final ProjectDAO projectDAO = new ProjectDAO();
    private final UserDAO userDAO = new UserDAO();
    private final AssignDAO assignDAO = new AssignDAO();
    private final List<User> userList = this.userDAO.findAll();
    private List<Integer> listUserId;

    public String execute() {
        return "success";
    }

    public String getAlll() {
        this.projectList = this.projectDAO.findAll();
        return "success";
    }

    public String getById() {
        this.project = this.projectDAO.findById(this.id);
        return "success";
    }

    public String addUser() {
        User u = this.userDAO.findById(this.listUserId.get(0));
        this.project = this.projectDAO.findById(this.id);
        if (this.assignDAO.add(u, this.project, this.assign.getDecription()) != null) {
            this.projectList = this.projectDAO.findAll();
            return "success";
        } else {
            this.projectList = this.projectDAO.findAll();
            addActionError("Already exits");
            return "error";
        }
    }

    public String addNew() {
        this.projectDAO.save(this.project);
        this.projectList = this.projectDAO.findAll();
        return "success";
    }

    public String deleteUser() {
        if (this.listUserId != null) {
            Project p = this.projectDAO.findById(this.id);
            for (Integer i : this.listUserId
                    ) {
                User u = this.userDAO.findById(i);
                Assign a = this.assignDAO.findByUserAndProject(u, p);
                this.assignDAO.delete(a.getId());
            }
        }
        this.projectList = this.projectDAO.findAll();
        return "success";
    }

    public String update() {
        Project p = this.projectDAO.findById(this.project.getId());
        p.setName(this.project.getName());
        this.project = this.projectDAO.save(p);
        return "success";
    }

    public List<Project> getProjectList() {
        return projectList;
    }

    public void setProjectList(List<Project> projectList) {
        this.projectList = projectList;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public List<User> getUserList() {
        return userList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Integer> getListUserId() {
        return listUserId;
    }

    public void setListUserId(List<Integer> listUserId) {
        this.listUserId = listUserId;
    }

    public Assign getAssign() {
        return assign;
    }

    public void setAssign(Assign assign) {
        this.assign = assign;
    }
}
