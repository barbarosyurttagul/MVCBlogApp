using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using MvcBlog.Model;

namespace MvcBlog.BLL
{
    public class ProcedureBL<T> : IBusiness<T> where T : class
    {
        PersonalBlogEntities ctx = new PersonalBlogEntities();

       

        public List<T> SelectAll()
        {
            return ctx.Set<T>().ToList();
        }

        public T SelectOne(Expression<Func<T, bool>> state)
        {
            return ctx.Set<T>().SingleOrDefault(state);
        }

        public List<T> SelectOrdered<TOrderType>(Expression<Func<T, bool>> state, Expression<Func<T, TOrderType>> orderExpression, Order order)
        {
            if (order==Order.INCREASE)
            {
                return ctx.Set<T>().Where(state).OrderBy(orderExpression).ToList();
            }

            return ctx.Set<T>().Where(state).OrderByDescending(orderExpression).ToList();
        }

        public List<T> SelectUnordered(Expression<Func<T, bool>> state)
        {
            if (state != null)
                return ctx.Set<T>().Where(state).ToList();
            return ctx.Set<T>().ToList();
        }

        public void Save(T entity)
        {
            if (Convert.ToInt32(entity.GetType().GetProperty("Id").GetValue(entity)) > 0)
            {
                Update();
            }

            else
            {
                Insert(entity);
            }
        }

        private void Insert(T entity)
        {
            ctx.Set<T>().Add(entity);
            ctx.SaveChanges();
        }

        private void Update()
        {
            ctx.SaveChanges();
        }

        public void Delete(T entity)
        {
            ctx.Set<T>().Remove(entity);
            ctx.SaveChanges();
        }

        

    }
}
