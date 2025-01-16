const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require("./models/room");
var io = require("socket.io")(server);

//middle ware

app.use(express.json());

const DB =
  "mongodb+srv://sambhav07:sambhav_07@cluster0.zhujp.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

io.on("connection", (socket) => {
  console.log("conected");

  socket.on("createRoom", async ({ nickname }) => {
    try {
      console.log(nickname);

      let room = new Room();

      let player = {
        socketId: socket.id,
        nickname: nickname,
        playerType: "X",
      };
      room.players.push(player);
      room.turn = player;
      room = await room.save();

      const roomId = room._id.toString();
      socket.join(roomId);
      console.log("Emitting createRoomSuccess with room data:", room);

      io.to(roomId).emit("createRoomSuccess", room);
    } catch (error) {
      console.error("Error creating room:", error);
      socket.emit("error", { message: "Failed to create room" });
    }
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit(
          "errorOccured",
          "Invalid RoomId :- please enter a valid room id"
        );
        return;
      }

      let room = await Room.findById(roomId);

      if (room.isJoin) {
        let player = {
          socketId: socket.id,
          nickname: nickname,
          playerType: "O",
        };

        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom",room);
      } else {
        socket.emit(
          "errorOccured",
          "Game is in progress please try again later"
        );
      }
    } catch (e) {
      console.log(e);
    }
  });


  socket.on("tap", async({index, roomId})=>{
    try{
      let room = await Room.findById(roomId);
      let choice = room.turn.playerType;

      if(room.turnIndex == 0){
        room.turnIndex = 1;
        room.turn = room.players[1];
      }else{
        room.turnIndex = 0;
        room.turn = room.players[0];
      }

      room = await room.save();

      io.to(roomId).emit("tapped", {index, choice , room });
      
    }catch(e){
      console.log(e);
    }
  });

  // socket.on("winner", async({winnerSocketId , roomId})=>{
  //   try{
  //     let room = await Room.findById(roomId);
  //     let player = room.players.find((playerr)=> playerr.socketId == winnerSocketId);
  //     player.points += 1;
  //     room = await room.save();
  //     if(player.points >= room.maxRounds){
  //       io.to(roomId).emit("endGame", player);
     
  //     }else{
  //       io.to(roomId).emit("pointIncrease", player);
  //     }

  //   }catch(e){
  //     console.log(e);
  //   }
  // })

  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      console.log("Room Players:", room.players);
    console.log("Winner Socket ID:", winnerSocketId);
      if (!room) {
        console.log("Room not found!");
        return;
      }
  
      let player = room.players.find((playerr) => playerr.socketId === winnerSocketId);
      if (!player) {
        console.log("Player not found in room!");
        return;
      }
  
      player.points += 1; // Increment points
      console.log(`Player ${player.nickname} now has ${player.points} points.`);
  
      // Save updated room
  
      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
        room = await room.save();
      } else {
        io.to(roomId).emit("pointIncrease", player);
        room = await room.save();
      }
    } catch (e) {
      console.log("Error in winner event:", e);
    }
  });
  
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("connected to database ");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`server has been started and is running on ${port}`);
});
