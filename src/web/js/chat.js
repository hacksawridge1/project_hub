function showChat() {
	let chatJson = new File(["chat"],"../objects/chat/443/chat.json");
	let chatJsonReader = new FileReader();
	console.log(chatJsonReader.readAsText(chatJson).result);
}

showChat()
