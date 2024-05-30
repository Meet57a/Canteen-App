const bcrypt = require("bcrypt")

const comparePassword = async (inputPassword, hashedPassword) => {
    try {
        const isMatch = await bcrypt.compare(inputPassword, hashedPassword)
        if(isMatch) {
            return true
        } else {
            return false
        }
    } catch(e) {
        throw err
    }
}

module.exports = comparePassword