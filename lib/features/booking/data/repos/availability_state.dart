import 'package:equatable/equatable.dart';
import 'package:medify/core/features/availability_model.dart';

abstract class AvailabilityState extends Equatable {
  const AvailabilityState();

  @override
  List<Object?> get props => [];
}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityLoaded extends AvailabilityState {
  final List<Availability> availability;
  const AvailabilityLoaded(
    this.availability,
  );

  @override
  List<Object?> get props => [availability];
}

//update availability
class AvailabilityUpdated extends AvailabilityState {
  final String message;
  const AvailabilityUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class AvailabilityError extends AvailabilityState {
  final String message;

  const AvailabilityError(this.message);

  @override
  List<Object?> get props => [message];
}
