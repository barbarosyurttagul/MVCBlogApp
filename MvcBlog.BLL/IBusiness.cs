using MvcBlog.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace MvcBlog.BLL
{
    public interface IBusiness<T>
    {
        List<T> SelectUnordered(Expression<Func<T, bool>> state);

        List<T> SelectOrdered<TOrderType>(Expression<Func<T, bool>> state,
                                          Expression<Func<T, TOrderType>> orderExpression, Order order);

        T SelectOne(Expression<Func<T, bool>> state);

        List<T> SelectAll();

        void Save(T entity);
        void Delete(T entity);
    }
}
