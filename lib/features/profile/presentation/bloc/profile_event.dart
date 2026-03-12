import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileUpdateRequested extends ProfileEvent {
  final String? name;
  final String? email;
  final String? phone;

  const ProfileUpdateRequested({
    this.name,
    this.email,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, phone];
}
