package dao;

import common.util.HibernateUtil;
import entity.Assign;
import entity.Project;
import entity.User;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;

public class AssignDAO {

    public Assign save(Assign assign){
        Transaction transaction = null;
        Assign a = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            a = (Assign) session.merge(assign);
            transaction.commit();
            return a;
        }catch (Exception e){
            return null;
        }
    }

    public Assign findById(int id){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.find(Assign.class,id);
        }catch (Exception e){
            return null;
        }
    }

    public List<Assign> findByUser(User user){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.createQuery("FROM Assign A WHERE A.userByUserId = :a_user",Assign.class).setParameter("a_user",user).getResultList();
        }catch (Exception e){
            return null;
        }
    }

    public Assign findByUserAndProject(User user,Project project){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.createQuery("FROM Assign A WHERE A.userByUserId = :a_user AND A.projectByProjectId = :a_project",Assign.class).setParameter("a_user",user).setParameter("a_project",project).getResultList().get(0);
        }catch (Exception e){
            return null;
        }
    }

    public List<Assign> findByProject(Project project){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.createQuery("FROM Assign A WHERE A.projectByProjectId = :a_project",Assign.class).setParameter("a_project",project).getResultList();
        }catch (Exception e){
            return null;
        }
    }

    public boolean delete(int id){
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            Assign assign = session.get(Assign.class,id);
            System.out.println(assign);
            session.remove(assign);
            transaction.commit();
            return true;
        }catch (Exception e){
            System.out.println(e);
            return false;
        }
    }

    public Assign add(User user,Project project,String decription){
        List<Project> listUser = new ArrayList<>();
        for (Assign a:findByUser(user)
             ) {
            listUser.add(a.getProjectByProjectId());
        }
        List<User> listProject = new ArrayList<>();
        for (Assign a : findByProject(project)
                ) {
            listProject.add(a.getUserByUserId());
        }
        if(!listUser.contains(project) && !listProject.contains(user))
            return save(new Assign(decription, user, project));
        else{
            return null;
        }
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findById(3);
        ProjectDAO projectDAO = new ProjectDAO();
        Project project = projectDAO.findById(1);
        AssignDAO assignDAO = new AssignDAO();Assign assign = new Assign("abcdef",user,project);
        System.out.println(assignDAO.findById(3));
    }
}
