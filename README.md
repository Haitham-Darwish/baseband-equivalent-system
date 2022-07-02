Part of communications project in cairo university faculty of Engineering 

# Table of content
  * [Introduction](#introduction)
  * [Single Carrier System](#-1-single-carrier-system)
    - [The Mapper](#-11-the-mapper)
    - [The channel](#-12-the-channel)
    - [The Demapper](#13-the-demapper)
    - [Tasks](#14-tasks)
  * [Graph](#graph)
  * [Comment](#comment)
 
# Introduction

The purpose of the project is to introduce the students to the simulation of the single 
carrier communication systems. The requirements of the project are described in the 
following sections

<h1> 1. Single Carrier System</h1> 
<p align="center">
<img src="https://user-images.githubusercontent.com/68920161/177015323-65cc36b0-1bba-46ab-ada4-64663215239a.png">
</p>

<h2> 1.1 The Mapper</h2>
The first block in the communication system under consideration is the mapper. The 
mapper takes the I/P data bits and produces the symbols to be transmitted on the channel.
The modulation schemes under consideration are the BPSK, QPSK, 8PSK, and 16QAM 
systems. Figure 2 shows the constellations.
 <h2> 1.2 The channel</h2>
 
 *The channel is an AWGN channel.* In this model, the channel just adds noise to the 
transmitted signal. In MATLAB, the command “randn” should be used to generate the 
AWGN.
 
<h2>1.3 The Demapper</h2>
The simple demapper in the model under consideration will take the output of the channel 
and decide on the symbol transmitted. The output bit stream of the receiver is compared 
to the input bit stream and the BER is calculated. 

<p align="center">

<img src="https://user-images.githubusercontent.com/68920161/177015480-125e16b5-fdba-45db-9f1e-3e9c34e85cf1.png">

</p>

<h2>1.4 Tasks</h2>

* All simulations are done on the baseband equivalent system, with no carriers. 
* It is required to plot curves for the BER Vs Eb/No for the four modulation 
schemes. On the same graph, the theoretical BER or a tight upper bound should 
be drawn for each one of the 4 modulation schemes

# Graph
<p align="center">

<img src="https://user-images.githubusercontent.com/68920161/177015563-305573c8-86df-4c14-97c8-e8cce051b6e2.png">

</p>

# Comment

* For BPSK and QPSK they have the same BER but since QPSK has smaller BW as we send XI and XQ we prefer to use QPSK to BPSK.

* For 8PSK we send more symbol but higher BER.

* For QAM we use the idea of ASK and PSK to send more symbol but the result each distance is smaller than the previous three, then larger probability of error then higher BER.  

* Also, as Eb/No decreases the BER decreases.

* We can observe that the calculated BER is not perfect of the theoretical and tight bound and that happen due to number of bits are not infinite as number of bits increase it tends to fit the theoretical and tight bound more.
