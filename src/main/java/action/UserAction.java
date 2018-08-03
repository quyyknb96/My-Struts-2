package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import dao.AssignDAO;
import dao.ProjectDAO;
import dao.UserDAO;
import entity.Assign;
import entity.Project;
import entity.User;
import org.apache.struts2.interceptor.validation.SkipValidation;

import java.util.List;

public class UserAction extends ActionSupport {
    private List<User> userList;
    private User user;
    private int id;
    private String newPassword, newPasswordRepeat;
    private final ProjectDAO projectDAO = new ProjectDAO();
    private final UserDAO userDAO = new UserDAO();
    private final AssignDAO assignDAO = new AssignDAO();
    private final List<Project> projectList = projectDAO.findAll();
    private List<Integer> listProjectId;
    private Assign assign;

    public void validate(){
            if (this.user.getUsername().length() == 0) {
                addFieldError("user.username", "Username is required");
            }
            if (this.user.getPassword().length() == 0) {
                addFieldError("user.password", "Password is required");
            }
    }

    @SkipValidation
    public String getAll() {
        this.userList = this.userDAO.findAll();
        return "success";
    }

    @SkipValidation
    public String getById() {
        this.user = this.userDAO.findById(this.id);
        return "success";
    }

    @SkipValidation
    public String addProject(){
        Project p = this.projectDAO.findById(this.listProjectId.get(0));
        this.user = this.userDAO.findById(this.id);
        if(this.assignDAO.add(this.user,p,this.assign.getDecription()) != null){
            this.userList = this.userDAO.findAll();
            return "success";
        }else {
            this.userList = this.userDAO.findAll();
            addActionError("Already exist");
            return "error";
        }
    }

    public String addNew(){
        if(this.userDAO.checkUsername(this.user.getUsername())) {
            this.userDAO.save(this.user);
            addActionMessage("Register successfully");
            return "success";
        }else {
            addActionError("Register fail. Please check your Username");
            return "error";
        }
    }

    @SkipValidation
    public String deleteProject(){
        if(this.listProjectId != null) {
            User u = this.userDAO.findById(this.id);
            for (Integer i : this.listProjectId
                    ) {
                Project p = this.projectDAO.findById(i);
                Assign a = this.assignDAO.findByUserAndProject(u, p);
                this.assignDAO.delete(a.getId());
            }
        }
        this.userList = this.userDAO.findAll();
        return "success";
    }

    @SkipValidation
    public String update() {
        User u = this.userDAO.findById(this.user.getId());
        u.setName(this.user.getName());
        this.user = this.userDAO.save(u);
        User us = (User) ActionContext.getContext().getSession().get("user");
        if (us.getId() == this.user.getId()) {
            ActionContext.getContext().getSession().put("user", this.user);
        }
        return "success";
    }

    @SkipValidation
    public String changPassword() {
        User u = this.userDAO.findById(this.user.getId());
        if (!this.user.getPassword().equals(u.getPassword())) {
            addActionError("Wrong password");
            return "error";
        } else if (this.newPassword == this.newPasswordRepeat){
            u.setPassword(this.user.getPassword());
            this.user = this.userDAO.save(u);
            addActionMessage("Change successfully");
            return "success";
        } else {
            addActionError("Wrong new password");
            return "error";
        }
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getNewPasswordRepeat() {
        return newPasswordRepeat;
    }

    public void setNewPasswordRepeat(String newPasswordRepeat) {
        this.newPasswordRepeat = newPasswordRepeat;
    }

    public List<Project> getProjectList() {
       return projectList;
    }

    public List<Integer> getListProjectId() {
        return listProjectId;
    }

    public void setListProjectId(List<Integer> listProjectId) {
        this.listProjectId = listProjectId;
    }

    public Assign getAssign() {
        return assign;
    }

    public void setAssign(Assign assign) {
        this.assign = assign;
    }
}
