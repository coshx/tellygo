package org.red5.core;

import org.apache.log4j.Logger;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.stream.ISubscriberStream;

public class Application extends ApplicationAdapter {
    private static final Logger log = Logger.getLogger(Application.class);

    @Override
    public boolean appStart(IScope arg0) {
        log.info("app start");
        return true;
    }
    
    @Override
    public void appStop(IScope arg0) {
        log.info("app stop");
    }
    
    /** {@inheritDoc} */
    @Override
    public boolean connect(IConnection conn, IScope scope, Object[] params) {
        IClient client = conn.getClient();
        log.info( "app connect " + client.getId());
        client.setAttribute("stamp", new Long(0));
        return true;
    }

    /** {@inheritDoc} */
    @Override
    public void disconnect(IConnection conn, IScope scope) {
        super.disconnect(conn, scope);
        log.info("app disconnect");
    }
    
    @Override
    public void streamSubscriberStart(ISubscriberStream stream) {
        log.info("stream subscriber start");
        
        IConnection conn = stream.getConnection();
        IClient client = conn.getClient();
        Long stamp = (Long)client.getAttribute("stamp");
        
        if (stamp == 0)
            client.setAttribute("stamp", System.currentTimeMillis());
    }
    
    @Override
    public void streamSubscriberClose(ISubscriberStream stream) {
        log.info("stream subscriber close");
    }
}
