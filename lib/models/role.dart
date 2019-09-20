enum Roles {admin, player}

class Role {
  static const admin = Roles.admin;
  static const player = Roles.player;

  final Roles role;

  Role({
    this.role,
  });

  factory Role.fromString(String role) => Role(role: _roleFromString(role));

  static Role roleFromString(String role) => Role.fromString(role);
  static Roles _roleFromString(String roleString) {
    Roles role;

    switch(roleString) {
      case 'admin': {
        role = admin;
        break;
      }

      default: {
        role = player;
      }
    }

    return role;
  }

  static String roleToString(Role role) => Role._roleToString(role);
  static String _roleToString(Role roleKlass) {
    String role;

    switch(roleKlass.role) {
      case admin: {
        role = 'admin';
        break;
      }

      default: {
        role = 'player';
      }
    }

    return role;
  }

  bool isAdmin() {
    return role == admin;
  }
}