package com.cmwebgame.team.demo.tx;

import java.sql.Connection;

import com.cmwebgame.core.Execution;
import com.cmwebgame.core.Interceptor;
import com.cmwebgame.core.InterceptorChain;
import com.cmwebgame.core.InterceptorOrder;
import com.cmwebgame.team.demo.util.DbUtils;

/**
 * Transaction interceptor.
 */
@InterceptorOrder(1)
public class TxInterceptor implements Interceptor {

    public void intercept(Execution execution, InterceptorChain chain) throws Exception {
        Connection connection = DbUtils.getConnection();
        connection.setAutoCommit(false);
        try {
            TxHolder.setCurrentConnection(connection);
            chain.doInterceptor(execution);
            connection.commit();
        }
        catch (Exception e) {
            connection.rollback();
            throw e;
        }
        finally {
            TxHolder.removeCurrentConnection();
        }
    }
}
