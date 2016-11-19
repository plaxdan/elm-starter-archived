'use strict';

require('./index.html');
const Elm = require('./Main');
const app = Elm.Main.embed(document.getElementById('main'));

const askQuestion = (question) => {
  const answer = prompt(question);
  app.ports.receivePrompt.send(answer);
}

app.ports.sendPrompt.subscribe(askQuestion);
