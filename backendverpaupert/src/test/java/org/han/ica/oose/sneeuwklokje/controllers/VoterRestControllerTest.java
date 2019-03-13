package org.han.ica.oose.sneeuwklokje.controllers;

import org.han.ica.oose.sneeuwklokje.dtos.voter.VoterRequest;
import org.han.ica.oose.sneeuwklokje.exceptions.SmartContractInteractionException;
import org.han.ica.oose.sneeuwklokje.services.voter.VoterService;
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
public class VoterRestControllerTest {
    @Mock
    private VoterService voterService;

    @InjectMocks
    private VoterRestController voterRestController;

    @Test
    public void testEmptyVoterRequest() throws SmartContractInteractionException {
        VoterRequest voterRequest = new VoterRequest();
        voterRequest.setId(-1);
        voterRequest.setToken("");

        when(voterService.doAuthenticationToken("")).thenReturn(false);

        Response response = voterRestController.vote(voterRequest);
        verify(voterService, Mockito.times(1)).doAuthenticationToken("");
        verify(voterService, Mockito.times(0)).pushVoteToBlockchain(Mockito.anyString(), Mockito.anyInt(), Mockito.anyInt()); //Verify no vote was given
        Assert.assertEquals(400, response.getStatus());
    }

    @Test
        public void testValidVoterRequest() throws SmartContractInteractionException {
        String token = "xxxx-yyyy-zzzz";
        int memberId = 10;
        int electionId = 1;

        VoterRequest voterRequest = new VoterRequest();
        voterRequest.setId(memberId);
        voterRequest.setToken(token);

        when(voterService.doAuthenticationToken(token)).thenReturn(true);
        when(voterService.getElectionIdBasedOnToken(token)).thenReturn(electionId);
        when(voterService.pushVoteToBlockchain(token, memberId, electionId)).thenReturn(true);

        Response vote = voterRestController.vote(voterRequest);

        verify(voterService, Mockito.times(1)).doAuthenticationToken(token);
        verify(voterService, Mockito.times(1)).getElectionIdBasedOnToken(token);
        verify(voterService, Mockito.times(1)).pushVoteToBlockchain(token, memberId, electionId);

        Assert.assertEquals(200, vote.getStatus());
    }
}
