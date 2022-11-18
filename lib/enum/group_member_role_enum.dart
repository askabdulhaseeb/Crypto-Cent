enum GroupMemberRoleEnum {
  admin('admin'),
  member('member');

  const GroupMemberRoleEnum(this.json);
  final String json;
}

class GroupMemberRoleEnumConvertor {
  static GroupMemberRoleEnum fromMap(String role) {
    if (role == 'admin') {
      return GroupMemberRoleEnum.admin;
    } else {
      return GroupMemberRoleEnum.member;
    }
  }
}
