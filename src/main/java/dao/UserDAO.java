package dao;

import common.util.HibernateUtil;
import entity.User;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.*;

public class UserDAO {

    public User save(User user) {
        User u = null;
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            u = (User) session.merge(user);
            transaction.commit();
        } catch (HibernateException e) {
        }
        return u;
    }

    public User findById(int id) {
        User u = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            u = session.find(User.class, id);
            return u;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean checkUsername(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<User> u = session.createQuery("FROM User U WHERE U.username = :user_username", User.class).setParameter("user_username", username).getResultList();
            if(u.size() > 0){
                return false;
            }else{
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public User checkLogin(String username, String password) {
        User u = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            u = session.createQuery("FROM User U WHERE U.username = :user_username AND U.password = :user_password", User.class).setParameter("user_username", username).setParameter("user_password", password).getResultList().get(0);
            return u;
        } catch (Exception e) {
            return null;
        }
    }

    public List<User> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<User> list = new ArrayList<>();
            list = session.createQuery("FROM User U", User.class).getResultList();
            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        System.out.println(userDAO.findById(3).toString());
    }
}
