package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.services.admin.AdminService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import javax.ws.rs.core.Response;

import static org.mockito.Mockito.verify;

@RunWith(MockitoJUnitRunner.class)
public class AdminRestControllerTest {

    @Mock
    private AdminService adminService;

    @InjectMocks
    private AdminRestController adminRestController;

    @Test
    public void TestIfOpenAdminPageAndShowRunningElectionsReturnsStatus200(){
        Response resp = adminRestController.openAdminPageAndShowRunningElections();
        verify(adminService, Mockito.times(1)).getRunningElections();
        Assert.assertEquals(200, resp.getStatus());
    }

    @Test
    public void TestIfCloseRunningElectionOnAdminPageReturnsStatus400() {
        int electionId = 0;
        Response resp = adminRestController.closeRunningElectionOnAdminPage(electionId);
        verify(adminService, Mockito.times(0)).closeRunningElection(electionId);
        Assert.assertEquals(400, resp.getStatus());
    }

    @Test
    public void TestIfCloseRunningElectionOnAdminPageReturnsStatus200() {
        int electionId = 1;
        Response resp = adminRestController.closeRunningElectionOnAdminPage(electionId);
        verify(adminService, Mockito.times(1)).closeRunningElection(electionId);
        Assert.assertEquals(200, resp.getStatus());
    }


}
