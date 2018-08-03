package dao;

import common.util.HibernateUtil;
import entity.Project;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public Project save(Project project){
        Project p = null;
        Transaction transaction  = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            p = (Project) session.merge(project);
            transaction.commit();
            return p;
        }catch (Exception e){
            return null;
        }
    }

    public Project findById(int id){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            Project p = session.createQuery("FROM Project p WHERE p.id = : p_id",Project.class).setParameter("p_id",id).getResultList().get(0);
            return p;
        }catch (Exception e){
            return null;
        }
    }

    public List<Project> findAll(){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            List<Project> list = new ArrayList<>();
            list = session.createQuery("FROM Project p",Project.class).getResultList();
            return list;
        }catch (Exception e){
            return null;
        }
    }

    public boolean delete(int id){
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            Project p = session.get(Project.class,id);
            session.remove(p);
            transaction.commit();
            return true;
        }catch (Exception e){
            return false;
        }
    }

    public static void main(String[] args) {
        ProjectDAO projectDAO = new ProjectDAO();
        Project project = new Project("aabbccddee");
        System.out.println(projectDAO.delete(2));

        for (Project p : projectDAO.findAll()
             ) {
            System.out.println(p.toString());
        }
    }
}
