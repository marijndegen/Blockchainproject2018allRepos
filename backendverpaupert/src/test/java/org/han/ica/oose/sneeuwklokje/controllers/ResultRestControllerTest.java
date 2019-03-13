package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.services.result.ResultService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import javax.ws.rs.core.Response;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ResultRestControllerTest {

    @Mock
    private ResultService resultService;

    @InjectMocks
    private ResultRestController resultRestController;

    @Test
    public void testIfGetListOfClosedElectionsReturnsStatus200() {
        Response resp = resultRestController.getListOfClosedElections();
        verify(resultService, Mockito.times(1)).closedElectionResponse();
        Assert.assertEquals(200, resp.getStatus());
    }

    @Test
    public void testIfGetElectionResultReturnsStatus200(){
        int id = 4;
        when(resultService.isElectionClosed(id)).thenReturn(true);
        Response resp = resultRestController.getElectionResult(id);
        verify(resultService, Mockito.times(1)).resultElectionResponse(id);
        Assert.assertEquals(200, resp.getStatus());
    }

    @Test
    public void testIfGetElectionResultReturnsStatus400(){
        int id = 4;
        when(resultService.isElectionClosed(id)).thenReturn(false);
        Response resp = resultRestController.getElectionResult(id);
        Assert.assertEquals(400, resp.getStatus());
    }
}
