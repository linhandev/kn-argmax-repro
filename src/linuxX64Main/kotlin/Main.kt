fun main() {
    var sum = 0L
    // Call generated functions to prevent dead-code elimination.
    // The actual count doesn't matter — we just need enough object files
    // to exceed ARG_MAX when the linker is invoked.
    sum += generated_file_00000()
    sum += generated_file_00001()
    sum += generated_file_09999()
    println("Sum = $sum")
}
