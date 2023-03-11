const Button = document.getElementById("button");
Button.addEventListener("click", clicked);

function clicked() {
    const Name = document.getElementById("name");
    document.getElementById("answer").innerHTML = "Hello, " + Name.value + ", nice to meet you!";
    
    switch (Name.toString().charAt(0)) {    // not working yet
        case 'E':
        case 'e':
            document.getElementById("answer").innerHTML += "...E for excellent";
        default:
            document.getElementById("answer").innerHTML += "...nothing";
    }
}