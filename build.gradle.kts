plugins {
    java
    application
}

group = "me.spencernold.tlang"
version = "1.0.0"

repositories {
    mavenCentral()
}

application {
    mainClass = "me.spencernold.tlang.Main"
}

val makeLexer by tasks.registering(JavaExec::class) {
    group = "build"
    description = "Generate lexer with JFlex"

    val outputDir = file("src/main/java/me/spencernold/tlang")
    val inputFile = file("src/main/lexer/me/spencernold/tlang/Lexer.flex")
    inputs.file(inputFile)
    outputs.dir(outputDir)
    doFirst {
        outputDir.mkdirs()
    }
    mainClass.set("jflex.Main")
    classpath = files(
        configurations.detachedConfiguration(
            dependencies.create("de.jflex:jflex:1.9.1")
        )
    )
    args = listOf(
        "--quiet",
        "--outdir", outputDir.absolutePath,
        inputFile.absolutePath
    )
}

tasks.compileJava {
    dependsOn(makeLexer)
}