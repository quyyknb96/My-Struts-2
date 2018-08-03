package entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "assign")
public class Assign {
    private int id;
    private String decription;
    private User userByUserId;
    private Project projectByProjectId;

    public Assign() {
    }

    public Assign(String decription, User userByUserId, Project projectByProjectId) {
        this.decription = decription;
        this.userByUserId = userByUserId;
        this.projectByProjectId = projectByProjectId;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "decription", nullable = true, length = 45)
    public String getDecription() {
        return decription;
    }

    public void setDecription(String decription) {
        this.decription = decription;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Assign assign = (Assign) o;
        return id == assign.id &&
                Objects.equals(decription, assign.decription);
    }

    @Override
    public String toString() {
        return "Assign{" +
                "id=" + id +
                ", decription='" + decription + '\'' +
                ", userByUserId=" + userByUserId +
                ", projectByProjectId=" + projectByProjectId +
                '}';
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "userId", referencedColumnName = "id", nullable = false)
    public User getUserByUserId() {
        return userByUserId;
    }

    public void setUserByUserId(User userByUserId) {
        this.userByUserId = userByUserId;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "projectId", referencedColumnName = "id", nullable = false)
    public Project getProjectByProjectId() {
        return projectByProjectId;
    }

    public void setProjectByProjectId(Project projectByProjectId) {
        this.projectByProjectId = projectByProjectId;
    }
}
